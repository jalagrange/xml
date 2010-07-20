#!/usr/bin/env ruby
#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---


Money = Struct.new(:currency, :amount)
Address = Struct.new(:street, :postal_code, :city)
Customer = Struct.new(:customer_no, :name, :address)
Vat = Struct.new(:rate, :amount)
Item = Struct.new(
  :product_id, :name, :unit_price, :quantity,
  :net_amount, :gross_amount, :vat
)
class Job
  attr_accessor :jobid, :user, :group, :jobname
  attr_accessor :queue, :ctime, :qtime, :etime, :start, :owner
end


require 'rexml/document'
class Job
  JOBS_DIR = File.join('data', 'jobs')
  
  def self.find(id)
    filename = File.join(JOBS_DIR, "#{id}.xml")
    job_doc = REXML::Document.new(File.new(filename))   
    job_node = job_doc.root.elements[1] 
    job = Job.new
    job.jobid = job_node.elements['jobid'].text
    job.user = job_node.elements['user'].text
    job.group = job_node.elements['group'].text
    job.jobname = job_node.elements['jobname'].text
    job.queue = job_node.elements['queue'].text
    job.ctime = job_node.elements['ctime'].text
    job.qtime = job_node.elements['qtime'].text
    job.etime = job_node.elements['etime'].text
    job.start = job_node.elements['start'].text
    job.owner = job_node.elements['owner'].text
    
    job
  end
end



class Job
  private
  
  def self.get_money(node)
    Money.new(node.attributes['currency'], node.attributes['amount'])
  end
  
  def self.get_customer(invoice_node)
    customer_node = invoice_node.elements['customer']
    Customer.new(
      customer_node.attributes['customer-no'],
      customer_node.elements['name'].text,
      get_address(customer_node)
    )
  end
  
  def self.get_address(customer_node)
    address_node = customer_node.elements['address']
    Address.new(
      address_node.elements['street'].text,
      address_node.elements['postal-code'].text,
      address_node.elements['city'].text
    )
  end
  
  def self.get_vat(invoice_node)
    Vat.new(
      invoice_node.elements['vat'].attributes['rate'],
      get_money(invoice_node.elements['vat'])
    )
  end
  
  def self.get_items(invoice_node)
    items = []
    invoice_node.elements.each('items/item') do |item|  
      items << Item.new(
        item.attributes['product-id'],
        item.elements['name'].text,
        get_money(item.elements['unit-price']),
        item.elements['quantity'].text.to_i,
        get_money(item.elements['net-amount']),
        get_money(item.elements['gross-amount']),
        item.elements['vat'].attributes['rate']
      )
    end
    items
  end
end

