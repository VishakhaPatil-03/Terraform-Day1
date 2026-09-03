#!/bin/bash

# Update packages
apt-get update -y

# Install Nginx
apt-get install -y nginx

# Enable and start Nginx
systemctl enable nginx
systemctl start nginx

# Create custom webpage
cat > /var/www/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Vishakha AWS Web Server</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-align: center;
        }

        .container {
            margin: 100px auto;
            padding: 50px;
            width: 60%;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        h1 {
            font-size: 45px;
        }

        p {
            font-size: 20px;
        }

        .status {
            color: #00ff88;
            font-weight: bold;
        }

        .box {
            margin-top: 30px;
            padding: 15px;
            background: rgba(255,255,255,0.15);
            border-radius: 10px;
        }
    </style>
</head>

<body>

    <div class="container">

        <h1>🚀 Welcome to My AWS Server</h1>

        <p>My custom webpage is running successfully!</p>

        <div class="box">
            <p>☁️ <b>AWS EC2</b></p>
            <p>🐧 <b>Ubuntu</b></p>
            <p>🌐 <b>Nginx Web Server</b></p>
            <p class="status">● Server is Running</p>
        </div>

        <p>Deployed using EC2 User Data</p>

        <p><b>Created by Vishakha Patil</b></p>

    </div>

</body>
</html>
EOF

# Restart Nginx
systemctl restart nginx