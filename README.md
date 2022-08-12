# Photo Album
This is a CLI to extract photo information from an endpoint, and print all photo IDs and Titles for a given album to STDOUT.

## Setup

### Ruby version
Ensure you have a version of Ruby 3.0 or later installed.

### Installing gems
To run this application, you will need to first install the Bundler gem with:
```
gem install bundler
```

Then you will need to install all other required gems with:
```
bundle install
```

## Running Tests
To run the test suite, use Rspec with:
```
bundle exec rspec
```

## Executing the script
To execute this script and receive a printout of the IDs and Titles for a specific album, run:
```
./photo-album :id
```
Where `:id` is the ID of the Album you want to see

If you wish to see a listing of all photos, regardless of album ID, run the script without passing an ID

```
./photo-album
```
