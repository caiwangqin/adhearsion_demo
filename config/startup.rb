unless defined? Adhearsion
  if File.exists? File.dirname(__FILE__) + "/../adhearsion/lib/adhearsion.rb"
    # If you wish to freeze a copy of Adhearsion to this app, simply place a copy of Adhearsion
    # into a folder named "adhearsion" within this app's main directory.
    require File.dirname(__FILE__) + "/../adhearsion/lib/adhearsion.rb"
  else
    require 'rubygems'
    gem 'adhearsion', '>= 0.8.2'
    require 'adhearsion'
  end
end

Adhearsion::Configuration.configure do |config|

  # Supported levels (in increasing severity) -- :debug < :info < :warn < :error < :fatal
  config.logging :level => :info

  # Whether incoming calls be automatically answered. Defaults to true.
  # config.automatically_answer_incoming_calls = false

  # Whether the other end hanging up should end the call immediately. Defaults to true.
  # config.end_call_on_hangup = false

  # Whether to end the call immediately if an unrescued exception is caught. Defaults to true.
  # config.end_call_on_error = false

  # NOTE: Pay special attention to the argument_delimiter field below:
  # For Asterisk <= 1.4, use "|" (default)
  # For Asterisk >= 1.6, use ","
  # This setting applies to AMI and AGI
  config.enable_asterisk :argument_delimiter => ','
  
  # add below to manager.conf first
  # [ahn_ami]
  # secret = bindoivrmanager
  # read  = system,call,log,verbose,command,agent,user
  # write   = system,call,log,verbose,command,agent,user
  config.asterisk.enable_ami :host => "173.230.155.114", :port => 5038, :username => "ahn_ami", :password => "bindoivrmanager", :events => true

  # config.enable_drb

  # Streamlined Rails integration! The first argument should be a relative or absolute path to
  # the Rails app folder with which you're integrating. The second argument must be one of the
  # the following: :development, :production, or :test.

  # config.enable_rails :path => 'gui', :env => :development

  # Note: You CANNOT do enable_rails and enable_database at the same time. When you enable Rails,
  # it will automatically connect to same database Rails does and load the Rails app's models.

  # Configure a database to use ActiveRecord-backed models. See ActiveRecord::Base.establish_connection
  # for the appropriate settings here.
  config.enable_database :adapter  => 'mysql',
                         :database => 'bindo_development',
                         :username => 'root',
                         :password => 'b1nd0',
                         :host     => 'localhost'

  # Configure an LDAP connection using ActiveLdap.  See ActiveLdap::Base.establish_connect
  # for the appropriate settings here.
  # config.enable_ldap :host => 'ldap.dataspill.org',
  #                    :port => 389,
  #                    :base => 'dc=dataspill,dc=org',
  #                    :logger => ahn_log.ldap,
  #                    :bind_dn => "uid=drewry,ou=People,dc=dataspill,dc=org",
  #                    :password => 'password12345',
  #                    :allow_anonymous => false,
  #                    :try_sasl => false

end

Adhearsion::Initializer.start_from_init_file(__FILE__, File.dirname(__FILE__) + "/..")
