class SalesforceContact < SalesforceBase
  #  cannot set_table_name here because we need a valid connection (because it connects!  when we do set_table_name!  wtf!!!!
#  set_table_name "Contact"
 
  def self.make_connection(config)
    establish_connection(config)
    set_table_name 'Contact'
  end
end
