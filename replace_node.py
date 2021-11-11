import os
import pathlib

def find_node_port():
    return os.system(
       "sudo kubectl get -o jsonpath='{.spec.ports[0].nodePort}' services bookingapp"
    )

def main():
    project_path = str(pathlib.Path(".").absolute())
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
