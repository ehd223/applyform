class Admin < ApplicationRecord
    has_secure_password
    def self.authenticate(name, password)
        admin = find_by_name(name)
        if admin && admin.password_digest == BCrypt::Engine.hash_secret(password, admin.password)
            return admin
        else
            return nil
    end
end
end
