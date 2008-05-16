class Salesforce::Contact < Salesforce::Base
  connection.set_class_for_entity(Salesforce::Contact, "Contact")
end
