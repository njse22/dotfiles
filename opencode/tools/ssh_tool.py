import sys
import json
import paramiko

def execute_ssh(hostname, username, key_path, command=None, action="exec", local_file=None, remote_file=None):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    try:
        k = paramiko.RSAKey.from_private_key_file(key_path) 
        ssh.connect(hostname=hostname, username=username, pkey=k, timeout=10)
        
        if action == "exec" and command:
            stdin, stdout, stderr = ssh.exec_command(command)
            return {"status": "success", "output": stdout.read().decode(), "error": stderr.read().decode()}
            
        elif action == "transfer" and local_file and remote_file:
            sftp = ssh.open_sftp()
            sftp.put(local_file, remote_file)
            sftp.close()
            return {"status": "success", "message": f"Archivo {local_file} transferido a {remote_file}"}
            
    except Exception as e:
        return {"status": "error", "message": str(e)}
    finally:
        ssh.close()

if __name__ == "__main__":
    args = json.loads(sys.argv[1])
    result = execute_ssh(
        hostname=args.get("hostname", "127.0.0.1"),
        username=args.get("username"),
        key_path=args.get("key_path"),
        command=args.get("command"),
        action=args.get("action", "exec"),
        local_file=args.get("local_file"),
        remote_file=args.get("remote_file")
    )
    print(json.dumps(result))
