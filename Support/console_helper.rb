require 'yaml'

module SidewaysCoding
	module JSConsole
		class << self
			
			def dependencies
				jsfile = 'file://' + ENV['TM_BUNDLE_SUPPORT'] + '/js/javascript_helper.js'
				jsfile = jsfile.gsub(" ","%20")
				cssfile = 'file://' + ENV['TM_BUNDLE_SUPPORT'] + '/css/style.css'
				cssfile = cssfile.gsub(" ","%20")
				return	"<script src='#{jsfile}' type='text/javascript' charset='utf-8'></script>" +
								"<link href='#{cssfile}' type='text/css' charset='utf-8' rel='stylesheet'></link>"
			end
			
			def preload_js_dependencies
				
				configuration = load_defaults
				
				puts '<script type="text/javascript" charset="utf-8">'
				# if configuration['preloadFiles'] != nil 
					configuration['preloadFiles'].each do |file| 
						puts 'window.postMessage(":load '+ file +'","tm-internal://local/");'
					# end
				end
				puts '</script>'
			
				
			end
			
			def load_defaults
				
				configuration_file_path = begin 
					
					path_to_global_file = ENV['TM_BUNDLE_SUPPORT'] + '/jsconsole_config.yaml'
					if ENV['TM_PROJECT_DIRECTORY'] != nil 
						path_to_project_file = ENV['TM_PROJECT_DIRECTORY'] + '/jsconsole_config.yaml'
						(File.exist? path_to_project_file)  ? path_to_project_file : path_to_global_file 
					else
						path_to_global_file 
					end
				end
								
				configuration_file = YAML::load_file(configuration_file_path)
				if configuration_file['preloadFiles'] != nil 
					preload_files = configuration_file['preloadFiles']
				else 
					preload_files = []
				end
				
				return {
					'selectDocumentAsDefault' => configuration_file['selectDocumentAsDefault'],
					'preloadFiles' => preload_files
				}
				
			end
			
			def edit_project_file_btn
				if ENV['TM_PROJECT_DIRECTORY'] != nil 
					return "<input type='button' class='editbtn' onClick='JsConsoleHelper.openProjectConfig(); return false;' value='Edit Project file' />"
				end				
			end
			
			def edit_global_file_btn
				return "<input type='button' class='editbtn' onClick='JsConsoleHelper.openGlobalConfig(); return false;' value='Edit Global file' />"
			end
			
		end
	end
end