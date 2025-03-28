vagrant up dc01
#do {$test = ssh -o BatchMode=yes vagrant@dc01 2>&1; $test; sleep 5} until ($test -match "Permission")
Start-Sleep -Seconds 420
vagrant up dc02
vagrant up pki01
vagrant up log01