#This function returns a list of Freight Items to be used for Motor Carrier Tax Filing
function Get-FreightItemsForMCTF($sqlfile,$cs,$of_FreightItemsAll){
    if(Test-Path $sqlfile){
        $sql = Get-Content $sqlfile -Raw
        $dt = new-object System.Data.DataTable
        $da = new-object System.Data.SqlClient.SqlDataAdapter $sql,$cs 
        $da.SelectCommand.CommandTimeout = 1800
        $null = $da.Fill($dt)
        $null = $da.Dispose()
        $dt |
            Select-Object * -ExcludeProperty RowError,RowState,Table,ItemArray,HasErrors |
            Export-Csv -NoTypeInformation $of_FreightItemsAll
        Import-Csv $of_FreightItemsAll
    }
}
Export-ModuleMember -Function 'Get-FreightItemsForMCTF'