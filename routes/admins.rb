class Admins < Cuba
  use Shield::Middleware, "/admin/login"
  settings[:layout] = "admin/layout"
  define do
    on "login" do
      on get do
        admin = Admin.first
        admin.blank? ? res.redirect("/install", 303) : res.write(view("admin/login", admin: admin))
      end

      on post, param("username"), param("password") do |user, pass|
        if login(Admin, user, pass, req[:remember])
          session[:success] = "You have successfully logged in."
          res.redirect(assert_return_path(req[:return]) || "/admin/dashboard")
        else
          session[:error] = "Invalid username and/or password combination."
          res.write view("admin/login", title: "Login", username: user)
        end
      end

      on default do
        session[:error] = "No username and/or password supplied."
        res.redirect "/admin/login", 303
      end
    end

    on authenticated(Admin) do
      run Admins
    end

    on default do
      res.status = 401
      res.write "Unauthorized"
    end
  end
end
