#=============Acceptance===================
class Person < ActiveRecord::Base
  validates :terms_of_service, :acceptance => true
end

#=============Validates_associated===================
class Library < ActiveRecord::Base
  has_many :books
  validates_associated :books
end

#=============Confirmation===================
class Person < ActiveRecord::Base
  validates :email, :confirmation => true
end
#--------View template would be------
<%= text_field :person, :email %>
<%= text_field :person, :email_confirmation %>

#==============Exclusion=================
class Account < ActiveRecord::Base
  validates :subdomain, :exclusion => { :in => %w(www us ca jp),
    :message => "Subdomain %{value} is reserved." }
end

#============Format============
class Product < ActiveRecord::Base
  validates :legacy_code, :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed" }
end

#===========Inclusion=============
class Coffee < ActiveRecord::Base
  validates :size, :inclusion => { :in => %w(small medium large),
    :message => "%{value} is not a valid size" }
end

#==========Length===========
class Person < ActiveRecord::Base
  validates :name, :length => { :minimum => 2 }
  validates :bio, :length => { :maximum => 500 }
  validates :password, :length => { :in => 6..20 }
  validates :registration_number, :length => { :is => 6 }
end

#=========Numericality===========
class Player < ActiveRecord::Base
  validates :points, :numericality => true
  validates :games_played, :numericality => { :only_integer => true }
end

#===========Presence===========
class Person < ActiveRecord::Base
  validates :name, :login, :email, :presence => true
end

class LineItem < ActiveRecord::Base
  belongs_to :order
  validates :order_id, :presence => true
end

#=============Uniqueness==========
class Account < ActiveRecord::Base
  validates :email, :uniqueness => true
end

class Holiday < ActiveRecord::Base
    validates :name, :uniqueness => { :scope => :year,
      :message => "should happen once per year" }
end

class Person < ActiveRecord::Base
  validates :name, :uniqueness => { :case_sensitive => false }
end

#==========Validates_with===========
class Person < ActiveRecord::Base
  validates_with GoodnessValidator
end
 
class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if record.first_name == "Evil"
      record.errors[:base] << "This person is evil"
    end
  end
end
#------------------------------------------------
class Person < ActiveRecord::Base
  validates_with GoodnessValidator, :fields => [:first_name, :last_name]
end
 
class GoodnessValidator < ActiveModel::Validator
  def validate(record)
    if options[:fields].any?{|field| record.send(field) == "Evil" }
      record.errors[:base] << "This person is evil"
    end
  end
end

#=========Validates_each============
lass Person < ActiveRecord::Base
  validates_each :name, :surname do |record, attr, value|
    record.errors.add(attr, 'must start with upper case') if value =~ /\A[a-z]/
  end
end

