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

  JOB_DIR = File.join('data', 'jobs')

  attr_reader :jobid, :user, :group, :jobname, :queue, :ctime
  attr_reader :qtime, :etime, :start, :owner

  def initialize(jobid, user, group, jobname, queue, ctime, qtime, etime, start, owner)
    @jobid, @user, @group, @jobname, @queue = jobid, user, group, jobname, queue
    @ctime, @qtime, @etime, @start, @owner = ctime, qtime, etime, start, owner
  end

  def self.build_from_xml()
    jobs = []
    input_file = "#{JOB_DIR}/1.xml"
    doc = XML::Document.file(input_file) 
    doc.find('//execution_record').each do |node| 
      jobs << Job.new(
        node.find('jobid').to_a.first.content,
        node.find('user').to_a.first.content,
        node.find('group').to_a.first.content,
        node.find('jobname').to_a.first.content,
        node.find('queue').to_a.first.content,
        node.find('ctime').to_a.first.content,
        node.find('qtime').to_a.first.content,
        node.find('etime').to_a.first.content,
        node.find('start').to_a.first.content,
        node.find('owner').to_a.first.content
       
      )
    end
    jobs
  end
end



