set_default(:puma_pid) { "#{current_path}/tmp/pids/puma.pid" }
set_default(:puma_state) { "#{shared_path}/tmp/pids/puma.state" }
set_default(:puma_sock) { "#{shared_path}/tmp/sockets/puma.sock" }
set_default(:puma_sock_ctl) { "#{shared_path}/tmp/sockets/pumactl.sock" }
set_default(:puma_config) { "#{shared_path}/config/puma.rb" }

namespace :puma do
	desc "Setup puma config"	
	task :setup, roles: :app do
		template "puma.rb.erb", puma_config
	end
	after "deploy:setup", "puma:setup"
end
