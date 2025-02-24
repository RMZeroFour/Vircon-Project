default:
    just --list

update-version new-version:
    sed -i 's/^# The Vircon Project v.*$/# The Vircon Project v{{new-version}}/' README.md
    sed -i 's/^project(vircon VERSION .* LANGUAGES CXX)$/project(vircon VERSION {{new-version}} LANGUAGES CXX)/' CMakeLists.txt
    sed -i 's/^const std::string_view gServerVersion = .*;$/const std::string_view gServerVersion = "{{new-version}}";/' server/version.hpp
    sed -i 's/^version: .*$/version: {{new-version}}/' flutter-client/pubspec.yaml
