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

class Job < ActiveRecord::Base

belongs_to :proceso
belongs_to :software
belongs_to :proyect

  JOB_DIR = File.join('data', 'jobs')

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
  
  def self.build_from_xml()
    jobs = []
    input_file = "#{JOB_DIR}/4.xml"
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
    jobs
  end

end



