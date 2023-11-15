$serials = get-content C:\tmp\Serials.txt
$headers = @{"Accept" = "application/json" }
$headers.Add("Authorization", "Bearer XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX-XXXXXXXXXX")

foreach ($Serial in $serials){
    $params = @{servicetags = $serial; Method = "GET" }
    $response = Invoke-RestMethod -Uri "https://apigtwb2c.us.dell.com/PROD/sbil/eapi/v5/assets" -Headers $headers -Body $params -Method Get -ContentType "application/json"
    $deviceInfo = [PSCustomObject]@{
        'serial' = $Response.ServiceTag
        'Model Name' = $response.productLineDescription
        'Purchase Date' = $response.shipdate
    }
$deviceinfo| select *| Export-Csv C:\tmp\Assets.csv -Append -NoTypeInformation
}
