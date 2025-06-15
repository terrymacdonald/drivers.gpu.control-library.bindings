
$bindingPath = "..\Bindings"

Write-Output "Changing all *_flag_t objects to uints in folder $bindingPath...";

Get-ChildItem -Path $bindingPath -Recurse -Filter '*_flag_t.cs' | ForEach-Object {
    $file = $_.FullName
    Write-Host "Patching file: $file"

    $content = Get-Content $file

    # Replace public enum XYZ { ... → public enum XYZ : uint { ...
    $patched = $content -replace '(?<=public enum\s+\w+)\s*\{', ' : uint {'

    if ($patched -ne $content) {
        Set-Content $file $patched
        Write-Host "  -> Patched to use : uint"
    } else {
        Write-Host "  -> No changes needed"
    }
}