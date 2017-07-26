![ConWorkShop image](http://i.imgur.com/UhDItX8.png)

# ConWorkShop
**ConWorkShop**, or CWS, is a constructed languages and constructed worlds management and tooling web application.

Currently, an older, closed-source PHP version is deployed at [http://conworkshop.com/](http://conworkshop.com/). This
version made in Ruby will replace it once a good deal of the work is done. :smiley:

## Getting started
### Dependencies
Install all the following dependencies on your machine:

- Ruby (>= 2.3)
- Rails (>= 5.0)
- PostgreSQL (>= 9.6, most likely works with earlier versions)
  - PostgreSQL’s development headers must be available in your `PATH`.
- ImageMagick (with version 6 compatibility tools, such as `identify` and `mogrify`)

Note: *Technically, you can use any database other than PostgreSQL, but we use PostgreSQL.*

### Installation
After every dependency is met, open your terminal in the project root and run

    $ bundle install

This will install all of ConWorkShop's other dependencies.

Now, go into the `config` folder and setup the `database.yml` and `secrets.yml` folder as per the examples. Once you have these set up as you wish, run

    $ bin/rake db:setup

Then, run `rails server` to spin up a development instance on your own machine.

## Contributing
Thank you for wanting to contribute to CWS! Basically, read the [CONTRIBUTING.md](CONTRIBUTING.md) file, and you should
be good to go.

## License
CWS’s code is under the Open Software License 3.0. See the [LICENSE.txt](LICENSE.txt) file for details.

## Acknowledgements
- Jay, a.k.a. hashi, for all of his hard work into the first version of CWS. We love you! :heart:

## Code of Conduct
The ConWorkShop project pledges to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). Basically, be nice.
