class LoginPage < SitePrism::Page
    path = "/"
    set_url (path)

    element :username, :xpath,'//input[@id="email"]'
    element :password, :xpath,'//input[@id="pass"]'
    element :buttonLogin, :xpath, '//button[@name="login"]'

    def isFieldLoginPresent()
        sleep 3
        expect(self).to have_username #bikinerror undefined method `expect'
        expect(self).to have_password #bikinerror undefined method `expect'
    end

    def fillLogin(username, pass)
        self.username.send_keys(username)
        self.password.send_keys(pass)
        sleep 2
    end

    def clickLogin()
        self.buttonLogin.click
    end
end