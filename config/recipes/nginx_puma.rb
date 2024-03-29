namespace :nginx do

	desc "Setup nginx configuration for this application"

	task :setup, roles: :web do
		template "nginx_puma.rb.erb", "/tmp/puma_conf"
		run "#{sudo} mv /tmp/puma_conf /etc/nginx/sites-enabled/#{application}"
		run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
		restart
	end
	after "deploy:setup", "nginx:setup"

	%w[start stop restart].each do |command|
		desc "#{command} nginx"
		
		task command, roles: :web do
		  run "#{sudo} service nginx #{command}"
		end
	end

end