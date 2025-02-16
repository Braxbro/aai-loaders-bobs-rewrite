mod_version := `jq -r .version < info.json`
mod_name := `jq -r .name < info.json`
mod_archive := mod_name + "_" + mod_version

@_default:
    just --list --justfile {{justfile()}}

package:
    mkdir -p release
    cp -r * release/{{mod_archive}}
    ouch compress -q "release/{{mod_archive}}" "release/{{mod_archive}}.zip"
    rm -rf "release/{{mod_archive}}"
