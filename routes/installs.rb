class Installs < Cuba
  settings[:layout] = 'admin/layout'
  define do
    on get do
      res.write view("install/install")
    end

    on post, param("username"), param("password"), params("password_confirmation") do |user, pass, pass_conf|
      # Todo
    end
  end
end
