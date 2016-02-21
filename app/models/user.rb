class User < ActiveRecord::Base
    has_many :articles
    before_save { self.email = email.downcase }
    # Before the user data hits db takes email value and turns it to lowercase
    # using downcase method and only THEN save it to the db
    
    validates   :username, presence: true, 
                uniqueness: {case_sensitive: false},
                # The {case_sensitive: false} ensures cases are ignored so "Joe" and "joe"
                # aren't inadvertently considered not unique thereby passing validation.
                length: { minimum: 3, maximum: 25 }
                
    VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
                
    validates   :email, presence: true, length: { maximum: 105 },
                uniqueness: { case_sensitive: false },
                format: { with: VALID_EMAIL_REGEX }
                # The above is going to check for valid format of email inputs.
                
    has_secure_password
    
end
