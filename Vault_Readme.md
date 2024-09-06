<h1><b>Terraform Vault<b></h1>
<h1>Commands to work with terraform vault</h1>
Install vault engine in server. First step should be Enabling secrets path in valut engine

    # vault secrets enable -path=my kv

Write key vaule pair secret with vault

    # vault kv put my/path name=ec2

Get key vaule pair secret with vault
    
    # vault kv get my/path

List all secrets
    # vault secrets list

Get key vaule secrets in json format

    # vault kv get -format=json my/path

Delete key value pair secret

    # vault kv delete my/path
