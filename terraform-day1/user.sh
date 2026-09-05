#!/bin/bash

# Update packages
apt-get update -y

# Install Nginx
apt-get install -y nginx

# Enable and start Nginx
systemctl enable nginx
systemctl start nginx

# Create attractive webpage
cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Terraform AWS Infrastructure</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #1e293b, #334155);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .container {
            width: 100%;
            max-width: 1000px;
        }

        .card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 25px;
            padding: 50px;
            text-align: center;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.4);
        }

        .badge {
            display: inline-block;
            padding: 8px 18px;
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 14px;
            margin-bottom: 25px;
            letter-spacing: 1px;
        }

        h1 {
            font-size: 52px;
            margin-bottom: 15px;
            background: linear-gradient(90deg, #38bdf8, #a78bfa);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .subtitle {
            font-size: 21px;
            color: #cbd5e1;
            margin-bottom: 35px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(34, 197, 94, 0.15);
            border: 1px solid rgba(34, 197, 94, 0.4);
            color: #86efac;
            padding: 12px 22px;
            border-radius: 30px;
            margin-bottom: 40px;
        }

        .dot {
            width: 10px;
            height: 10px;
            background: #22c55e;
            border-radius: 50%;
            box-shadow: 0 0 12px #22c55e;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .feature {
            padding: 25px 15px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s ease;
        }

        .feature:hover {
            transform: translateY(-7px);
        }

        .icon {
            font-size: 35px;
            margin-bottom: 12px;
        }

        .feature h3 {
            margin-bottom: 8px;
            font-size: 18px;
        }

        .feature p {
            color: #94a3b8;
            font-size: 14px;
        }

        .info {
            margin-top: 35px;
            padding-top: 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #94a3b8;
            font-size: 14px;
        }

        .highlight {
            color: #38bdf8;
            font-weight: bold;
        }

        footer {
            margin-top: 20px;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 700px) {
            .card {
                padding: 30px 20px;
            }

            h1 {
                font-size: 38px;
            }

            .features {
                grid-template-columns: 1fr;
            }

            .subtitle {
                font-size: 17px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="card">

        <div class="badge">
            ☁️ AWS CLOUD INFRASTRUCTURE
        </div>

        <h1>Hello from Terraform!</h1>

        <p class="subtitle">
            Infrastructure as Code • Ubuntu • Nginx
        </p>

        <div class="status">
            <span class="dot"></span>
            Server is Running Successfully
        </div>

        <div class="features">

            <div class="feature">
                <div class="icon">🚀</div>
                <h3>Terraform</h3>
                <p>Infrastructure provisioned automatically using Terraform.</p>
            </div>

            <div class="feature">
                <div class="icon">☁️</div>
                <h3>AWS EC2</h3>
                <p>Application deployed on an Ubuntu EC2 instance.</p>
            </div>

            <div class="feature">
                <div class="icon">⚡</div>
                <h3>Nginx</h3>
                <p>High-performance web server serving this application.</p>
            </div>

        </div>

        <div class="info">
            <p>
                Environment:
                <span class="highlight">Training</span>
            </p>

            <p>
                Managed By:
                <span class="highlight">Terraform</span>
            </p>

            <p>
                Project:
                <span class="highlight">AWS Cloud Infrastructure</span>
            </p>
        </div>

    </div>

    <footer>
        © 2026 AWS & Terraform Infrastructure Project
    </footer>

</div>

</body>
</html>
HTML

# Restart Nginx
systemctl restart nginx

# Verify Nginx
systemctl is-active nginx