Import-Module SqlServer
#This function returns a list of Freight Items to be used for Motor Carrier Tax Filing
#Takes a file with sql and a connection string, retrieves data using invoke-sqlcmd
# saves data to an output file and reimports it to normalize the input with other
# processes that start with csv and finally returns the data.
function Get-FreightItemsForMCTF($sql,$cs,$of_FreightItemsAll){
    $FreightItems = Invoke-Sqlcmd -InputFile $sql -ConnectionString $cs -QueryTimeout 1800 |
        Select-Object * -ExcludeProperty RowError,RowState,Table,ItemArray,HasErrors
    $FreightItems | Export-Csv -NoTypeInformation $of_FreightItemsAll
    $FreightItems = Import-Csv $of_FreightItemsAll
    $FreightItems
}
Export-ModuleMember -Function * -Alias *