import subprocess

def find_node_port():
    process = subprocess.Popen([
        "sudo", "kubectl", "get", "-o", "jsonpath='{.spec.ports[0].nodePort}'", "services", "bookingapp"],
        stdout=subprocess.PIPE, 
        stderr=subprocess.PIPE
        )
    stdout, stderr = process.communicate()
    return stdout.decode("utf-8").replace("'","")
    

def main():
    project_path = "/home/ubuntu/bookingapp/project/nginx.conf"
    nginx_path_file = project_path + "/nginx.conf"
    with open(nginx_path_file, "r") as nginx:
        nginx_commands = nginx.read()
        if not nginx_commands:
            raise ValueError("File is empty")
    
    with open(nginx_path_file, "w") as nginx:
        NODE_PORT = find_node_port()
        nginx_commands = nginx_commands.replace("#NODE_PORT#", str(NODE_PORT))
        nginx.write(nginx_commands)

if __name__ == '__main__':
    main()
