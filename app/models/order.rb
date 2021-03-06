class Order < ActiveRecord::Base
  
  has_many :line_items, dependent: :destroy
    
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  after_create :new_order


  def new_order
   OrderMailer.new_order(self).deliver
  end
  
  

end
