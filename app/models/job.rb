#!/usr/bin/env ruby
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---

require 'xml/libxml'
require 'net/ssh'
require 'net/scp'

class Job < ActiveRecord::Base

belongs_to :proceso
belongs_to :software
belongs_to :project

SeriesData = Struct.new(:name, :data)

JOB_DIR = File.join('data', 'xml')

    def self.groups
      find(
         :all,
         :select => '`group`, COUNT(`group`) AS number_of_jobs',
         :group  => '`group`'
         )
    end

    def self.process
      find(
         :all,
         :select => '*, COUNT(`proceso_id`) AS number_of_jobs',
         :group  => '`proceso_id`'
         )
    end

    def self.total_memory_by_day
      find(
          :all,
          :select => "day, SUM(memory) as data_attribute, 'Memory' as name",
          :group => "day")
    end

    def self.total_virtual_memory_by_day
      find(
          :all,
          :select => "day, SUM(virtual_memory) as data_attribute, 'Virtual Memory' as name",
          :group => "day")
    end
  
    def self.total_walltime_by_day
      find(
          :all,
          :select => "day, SUM(walltime) as data_attribute, 'Walltime' as name",
          :group => "day")
    end
    
    def self.total_cput_by_day
      find(
          :all,
          :select => "day, SUM(cput) as data_attribute, 'CPU Time' as name",
          :group => "day")
    end
    
    def self.total_queue_time_by_day
      find(
          :all,
          :select => "day, SUM(start) - SUM(ctime) as data_attribute, 'Queue Time' as name",
          :group => "day")
    end
    
    
    
  def self.time_in_queue
    sum(:start) - sum(:ctime)
  end
  
  def self.time_in_execution
    sum(:end) - sum(:start)
  end
  
  def self.memory
    sum(:memory)
  end
  
  def self.virtual_memory
    sum(:virtual_memory)
  end
  
  def self.cput
     sum(:cput)
  end
  
  def self.walltime
     sum(:walltime)
  end
  
  def js_pie_chart(attr)
    "['#{self.day}', #{self.send(attr)}],"
  end
  
  def js_line_chart(attr)
    "[#{self.day.to_time(:utc).to_i * 1000}, #{self.send(attr)}],"
    
  end
  
  def self.build_from_xml

    @file_name = ((Time.now)-(1.day)).strftime("%Y%m%d") + ".xml"
    @host = 'account'
    @user = 'account'
    @pass = '2hot2work'

    Net::SCP.start( @host, @user, :password => @pass ) do |scp|   
      scp.download!( "/usr/local/accounting/xml/#{@file_name}", 'data/xml' ) do |ch, name, sent, total|
        puts "#{name}: #{sent}/#{total}"
      end
    end

    @jobs = []
    input_file = "#{JOB_DIR}/#{@file_name}"
    doc = XML::Document.file(input_file) 
    doc.find('//execution_record').each do |node| 
      if node.find('group').to_a.first.content == "neuro"
        jobs << Job.new(
        :jobid => node.find('jobid').to_a.first.content,
        :day => node.find('date/day').to_a.first.content,
        :time => node.find('date/time').to_a.first.content,
        :user => node.find('user').to_a.first.content,
        :group => node.find('group').to_a.first.content,
        :jobname => node.find('jobname').to_a.first.content,
        :queue => node.find('queue').to_a.first.content,
        :ctime => node.find('ctime').to_a.first.content,
        :qtime => node.find('qtime').to_a.first.content,
        :etime => node.find('etime').to_a.first.content,
        :start => node.find('start').to_a.first.content,
        :owner => node.find('owner').to_a.first.content,
        :session => node.find('session').to_a.first.content,
        :end => node.find('end').to_a.first.content,
        :exit_status => node.find('exit_status').to_a.first.content,
        :node_name => node.find('resources_used/exec_host/node/nodename').to_a.first.content,
        :cpu => node.find('resources_used/exec_host/node/cpu').to_a.first.content,
        :cput => node.find('resources_used/cput').to_a.first.content,
        :memory => node.find('resources_used/mem/memory').to_a.first.content,
        :virtual_memory => node.find('resources_used/vmem/memory').to_a.first.content,
        :walltime => node.find('resources_used/walltime').to_a.first.content	
        )
      end
    end
    remove_xml = `rm data/xml/#{@file_name}`
    jobs
  end

  def self.save_xml
    @jobs = Job.build_from_xml()
    for job in @jobs do
     @split = job.jobname.split('_')
      job.project = Project.find_by_name(@split[0])
      job.proceso = Proceso.find_by_name(@split[1])
      job.walltime = total_seconds(job.walltime)
      job.cput = total_seconds(job.cput)
      job.time_in_queue = (job.start.to_i) - (job.ctime.to_i)
      job.time_in_execution = (job.end.to_i) - (job.start.to_i)
      job.save
    end
  end

  def self.disk_free()
    diskfree = `du -h /Users/juanlagrange/Sites/xml/data/projects`
    folders = diskfree.split(/\n/)
  end

  def self.ssh_test
    @file_name = ((Time.now)-(1.day)).strftime("%Y%m%d") + ".xml"
    puts "test"
    remove_xml = `rm data/xml/#{@file_name}`

  end
  

end



