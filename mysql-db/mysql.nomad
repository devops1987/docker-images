job "MySQL:5.7"{      //jobID
	datacenters=[
		"default"   
	]
	type="service"
	namespace="Mars-dev"
	constraint{
		attribute="${meta.app_id}"
		value="2"
	}
	constraint{
		attribute="${meta.env}"
		value="dev"
	}
	meta{
		_time="0"
	}
	update{
		max_parallel=1
		min_healthy_time="10s"
		healthy_deadline="3m"
		auto_revert=true
		canary=0
	}
	group "MySQL"{
		count=1
	
		restart{
			attempts=10
			interval="5m"
			delay="25s"
			mode="delay"
		}
	
		ephemeral_disk{
			migrate = true
			size=300
			sticky  = true
		}
		
		task "mars-dev"{
	
			driver="docker"
		  
			env{
				MYSQL_ROOT_PASSWORD="123456"    //必须设置，管理员用户root的密码
			}
		  
			config{
				image="hub.skyinno.com/google_containers/mysql:5.7.20"
			
				force_pull=true
			
				port_map{
					db = 3306
				}
			
				volumes = [
					"docker-entrypoint-initdb.d/:/docker-entrypoint-initdb.d/",
				]
			
			}
				
			template {
				data = <<EOH
				CREATE DATABASE dbwebappdb;
				CREATE USER 'dbwebapp'@'%' IDENTIFIED BY 'dbwebapp';
				GRANT ALL PRIVILEGES ON dbwebappdb.* TO 'dbwebapp'@'%';
				EOH
					
				destination = "/docker-entrypoint-initdb.d/db.sql"
			}
					  
			logs{
				max_files=10
				max_file_size=15
			}
			resources{
				cpu=500
				memory=512
			
				network{
					mbits=100
			  
					port "db" {}
				}
			}
		}
	}
}
