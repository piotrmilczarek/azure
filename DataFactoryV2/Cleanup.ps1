[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$DataFactoryName,
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
)

Write-Host -NoNewline "Removing triggers: "
foreach ($tr in (Get-AzureRmDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName)) {
    Write-Host -ForegroundColor Cyan -NoNewline $tr.Name, "..."
    if ($tr.RuntimeState -ne 'Stopped') {
        $out = Stop-AzureRmDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $tr.name -Force
    }
    $out = Remove-AzureRmDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $tr.Name -Force
}
Write-Host -ForegroundColor Green "[DONE]"

Write-Host -NoNewline "Removing pipelines: "
foreach ($pl in (Get-AzureRmDataFactoryV2Pipeline -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName)) {
    Write-Host -ForegroundColor Cyan -NoNewline $pl.Name, "..."
    $out = Remove-AzureRmDataFactoryV2Pipeline -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $pl.Name -Force
}
Write-Host -ForegroundColor Green "[DONE]"

Write-Host -NoNewline "Removing datasets: "
foreach ($ds in (Get-AzureRmDataFactoryV2Dataset -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName)) {
    Write-Host -ForegroundColor Cyan -NoNewline $ds.Name, "..."
    $out = Remove-AzureRmDataFactoryV2Dataset -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $ds.Name -Force
}
Write-Host -ForegroundColor Green "[DONE]"

Write-Host -NoNewline "Removing linked services: "
foreach ($ls in (Get-AzureRmDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName)) {
    Write-Host -ForegroundColor Cyan -NoNewline $ls.Name, "..."
    $out = Remove-AzureRmDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $ls.Name -Force
}
Write-Host -ForegroundColor Green "[DONE]"

Write-Host -NoNewline "Removing integration runtimes: "
foreach ($ir in (Get-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName)) {
    Write-Host -ForegroundColor Cyan -NoNewline $ir.Name, "..."
    $out = Remove-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $ir.Name -Force
}
Write-Host -ForegroundColor Green "[DONE]"
