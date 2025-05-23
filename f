Enter passphrase for key '/Users/tigranadaman/.ssh/id_ed25519': 
Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-1007-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

5 updates could not be installed automatically. For more details,
see /var/log/unattended-upgrades/unattended-upgrades.log
Last login: Fri May 16 16:18:45 2025 from 45.140.204.87
ploi@configurator:~$ ls
configurator.pc
ploi@configurator:~$ ls /var/www/goldshinetrade.ru
README.md      config              package.json       storage
app            database            phpunit.xml        tailwind.config.js
artisan        docker              postcss.config.js  tests
bootstrap      docker-compose.yml  public             vendor
composer.json  jsconfig.json       resources          vite.config.js
composer.lock  package-lock.json   routes
ploi@configurator:~$ cd /var/www/goldshinetrade.ru
ploi@configurator:/var/www/goldshinetrade.ru$ nano .env
ploi@configurator:/var/www/goldshinetrade.ru$ cd
ploi@configurator:~$ ls
configurator.pc
ploi@configurator:~$ cd configurator.pc
ploi@configurator:~/configurator.pc$ nano .env
ploi@configurator:~/configurator.pc$ cd
ploi@configurator:~$ cd /var/www/goldshinetrade.ru
ploi@configurator:/var/www/goldshinetrade.ru$ .env
-bash: .env: command not found
ploi@configurator:/var/www/goldshinetrade.ru$ nano .env
ploi@configurator:/var/www/goldshinetrade.ru$ cd
ploi@configurator:~$ cd configurator.pc
ploi@configurator:~/configurator.pc$ nano .env

  GNU nano 7.2                          .env                                    
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=log
MAIL_SCHEME=null
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

VITE_APP_NAME="${APP_NAME}"


^G Help      ^O Write Out ^W Where Is  ^K Cut       ^T Execute   ^C Location
^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^/ Go To Line
