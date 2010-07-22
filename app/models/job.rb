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

    def self.groups()
      Job.find(
         :all, 
         :select => 'count(*) count, group', 
         :group => 'group')
    end

  def self.build_from_xml()
    jobs = []
    input_file = "#{JOB_DIR}/3.xml"
    doc = XML::Document.file(input_file) 
    doc.find('//execution_record').each do |node| 
      jobs << Job.new(
        :jobid => node.find('jobid').to_a.first.content,
        :user => node.find('user').to_a.first.content,
        :group => node.find('group').to_a.first.content,
        :jobname => node.find('jobname').to_a.first.content,
        :queue => node.find('queue').to_a.first.content,
        :ctime => node.find('ctime').to_a.first.content,
        :qtime => node.find('qtime').to_a.first.content,
        :etime => node.find('etime').to_a.first.content,
        :start => node.find('start').to_a.first.content,
        :owner => node.find('owner').to_a.first.content
       
      )
    end
    jobs
  end

end



