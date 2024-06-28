set dotenv-load

@_default:
    just --list

build RECIPE="./recipes/recipe.yml":
    bluebuild build {{ RECIPE }}
