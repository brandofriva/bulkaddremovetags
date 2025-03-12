# BULK ADD (MERGE) TAGS
# Method to updates tags - see bottom to change parameters
function Merge-TagsFunction ($tagname, $tagvalue, $resourcegroup, $searchtagname, $searchtagvalue) {
	$param = "Get-AzResource "
	if ($searchtagname -ne $null -and $searchtagname -ne '') {$param = "$param -TagName ""$searchtagname"""}
	if ($searchtagvalue -ne $null -and $searchtagvalue -ne '') {$param = "$param -TagValue ""$searchtagvalue"""}
	if ($resourcegroup -ne $null -and $resourcegroup -ne '') {$param = "$param -ResourceGroupName ""$resourcegroup"""}
    $resources = iex $param
	#Write-Host $param

    foreach ($resource in $resources) {
        Write-Host "Adding tag from " $resource.Name
		$mergetag = @{"$tagname" = "$tagvalue" }
		#Write-Host "Update-AzTag -ResourceId " $resource.ResourceId " -Tag " $mergetag " -Operation Merge"
        Update-AzTag -ResourceId $resource.ResourceId -Tag $mergetag -Operation Merge
        Write-Host "Tag added to " $resource.Name -ForegroundColor Green
    }
}

# CHANGE PARAMETERS HERE
# If tags are blank they are ignored (Search* parameters used to filter resources; tag* used to provide tags to add)
Merge-TagsFunction -SearchTagName "" -SearchTagValue "" -tagname "DeleteThisTag" -tagvalue "1234" -resourcegroup "TestTagList"