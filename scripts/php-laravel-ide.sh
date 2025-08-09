#!/bin/bash

# Exit on error
set -e

# Step 1: Require the Laravel IDE Helper package
echo "Installing Laravel IDE Helper package..."
composer require --dev barryvdh/laravel-ide-helper

# Step 2: Publish the config
echo "Publishing IDE Helper config..."
php artisan vendor:publish --provider="Barryvdh\LaravelIdeHelper\IdeHelperServiceProvider" --tag=config

# Step 3: Update the configuration in ide-helper.php
CONFIG_FILE="config/ide-helper.php"
if [ -f "$CONFIG_FILE" ]; then
  echo "Updating ide-helper.php configuration..."
  sed -i.bak \
    -e "s/'filename' => '_ide_helper.php',/'filename' => '.ide_helper\/_ide_helper.php',/" \
    -e "s/'models_filename' => '_ide_helper_models.php',/'models_filename' => '.ide_helper\/_ide_helper_models.php',/" \
    -e "s/'meta_filename' => '.phpstorm.meta.php',/'meta_filename' => '.ide_helper\/.phpstorm.meta.php',/" \
    "$CONFIG_FILE"
  echo "Configuration updated."
else
  echo "Error: Config file $CONFIG_FILE not found. Exiting."
  exit 1
fi

# Step 4: Create the .ide_helper directory
IDE_HELPER_DIR=".ide_helper"
if [ ! -d "$IDE_HELPER_DIR" ]; then
  echo "Creating .ide_helper directory..."
  mkdir "$IDE_HELPER_DIR"
  echo ".ide_helper directory created."
else
  echo ".ide_helper directory already exists. Skipping."
fi

# Step 5: Initialize PHPActor configuration
echo "Initializing PHPActor configuration..."
phpactor config:initialize

# Step 6: Add "indexer.stub_paths" to PHPActor's config.json
PHP_ACTOR_CONFIG=".phpactor.json"
if [ -f "$PHP_ACTOR_CONFIG" ]; then
  echo "Adding indexer.stub_paths to PHPActor configuration..."
  # Use jq to modify or add the key
  jq '.["indexer.stub_paths"] = ["%project_root%/.ide_helper/"]' "$PHP_ACTOR_CONFIG" >"$PHP_ACTOR_CONFIG.tmp" && mv "$PHP_ACTOR_CONFIG.tmp" "$PHP_ACTOR_CONFIG"
  echo "indexer.stub_paths added to PHPActor configuration."
else
  echo "Error: PHPActor config.json not found at $PHP_ACTOR_CONFIG. Skipping."
fi

# Step 7: Generate IDE Helper files
echo "Generating IDE Helper files..."
php artisan ide-helper:generate
php artisan ide-helper:models
php artisan ide-helper:meta

echo "IDE Helper setup complete!"cho "Setup complete!"
