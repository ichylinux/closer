# 0.13.0
Release Date: 2024-11-10
* add support for cucumber-4
* drop support for cucumber-3

# 0.11.0
Release Date: 2023-09-01

### Removed
* drop support for ruby-2.5, 2.6

# 0.10.1
Release Date: 2021-01-28

### Added
* add support for selenium-webdriver v4

# 0.9.6
Release Date: 2020-01-11

### fixed
* load database.yml as ERB template

### Removed
* drop support for ruby-2.4

# 0.9.5
Release Date: 2019-08-12

### Removed
* drop support for ruby-2.3

# Version 0.9.4

Release Date: 2019-05-09

#### Added
* environment variable PLATFORM to specify platform of saucelabs

# Version 0.9.3

Release Date: 2019-05-07

#### Changed
* use port 3000 when running tests on travi-ci.

# Version 0.9.2

Release Date: 2018-07-25

#### Changed
* fix runtime dependency

# Version 0.9.0

Release Date: 2018-07-23

### Added
* when running user stories, snapshot is loaded/dumped and can resume from a failed feature.

# Version 0.8.0

Release Date: 2018-07-14

### Added
* add support for DRIVER=headless_firefox

### Removed
* drop support for DRIVER=poltergeist

# Version 0.7.3
Release Date: 2018-05-16

### Changed
* skip taking screenshot when env CI=travis

# Version 0.7.2
Release Date: 2018-05-09

### Changed
* drop support for ruby-2.2
* require capybara explicitly

# Version 0.7.1
Release Date: 2018-04-14

### Changed
* use MultiTest.disable_autorun explicitly
* set default window size for headless_chrome to 1280,720

# Version 0.7.0
Release Date: 2018-04-10

### Changed
* support headless chrome as default driver
  chromedriver is required to run without DRIVER environment variable.

# Version 0.6.2
Release Date: 2018-02-21

### Changed
* force rcov output to be utf-8

# Version 0.6.1
Release Date: 2018-01-05

### Changed
* run scenario without steps
* flacky test cases are judged as pass

# Version 0.6.0
Release Date: 2017-12-15

### Changed
* drop support for cucumber-2.x
* drop support for ruby-2.1

# Version 0.5.5
Release Date: 2017-10-20

### Fixed
* fixed error when passing string argument to with_capture.

# Version 0.5.4
Release Date: 2017-10-09

### Changed
* add support for cucumber-3.x
* environment variable RETRY will set --retry option

# Version 0.5.3
Release Date: 2017-09-23

### Changed
* start using format pretty again.
* capture screenshot on failure/error when format junit is specified.

# Version 0.5.2
Release Date: 2017-08-29

### Changed
* stop using format pretty

# Version 0.5.1
Release Date: 2017-05-23

### Added
* add support for chrome

# Version 0.5.0
Release Date: 2017-05-22

### Added
* add support for Sause Labs

# Version 0.4.2
Release Date: 2017-05-21

### Changed
* drop support for webkit
* run features randomly unless environment variable SORT is passed

# Version 0.4.1
Release Date: 2017-03-17

### Fixed
* don't include title attribute when empty.
* minitest integration

# Version 0.3.8
Release Date: 2016-08-20

### Changed
* drop support for ruby-2.0

# Version 0.3.7
Release Date: 2016-05-11

### Added
* add support for ruby 2.3.x when FORMAT=junit is specified

# Version 0.3.6
Release Date: 2016-05-10

### Added
* add support for ruby 2.3.x
