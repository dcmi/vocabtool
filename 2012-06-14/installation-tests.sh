# 2012-06-11 tests - all passed :-)
# Edited data and build.xml to reflect a publication date of 2012-06-14.
# Re-generated all schemas and HTML files.
# Compared older build to new build to ensure that the scripts were working properly (and that no ad-hoc edits had been introduced).
# After running the following comparisons, deleted the older data and build results.
# Edited /README, listing all steps needed to edit and build a new release.

#diff build-20120612/dctype.rdf                             build/dctype.rdf                        # ok - only date has changed (as expected)
#diff build-20120612/dcam.rdf                               build/dcam.rdf                          # ok - only date has changed (as expected)
#diff build-20120612/dcterms.rdf                            build/dcterms.rdf                       # ok - only date has changed (as expected)
#diff build-20120612/dcelements.rdf                         build/dcelements.rdf                    # ok - only date has changed (as expected)
#diff build-20120612/html/dcmi-terms/index.shtml            build/html/dcmi-terms/index.shtml       # ok - only date has changed (as expected)
#diff build-20120612/html/history/index.shtml               build/html/history/index.shtml          # ok - only date has changed (as expected)
#diff 2012-06-01/headers/header-rdf-dctype.xml              2012-06-14/headers/header-rdf-dctype.xml # ok - only date has changed (as expected)
#diff 2012-06-01/xmldata/dctype.xml                         2012-06-14/xmldata/dctype.xml           # ok - nothing changed (as expected)
#diff 2012-06-01/headers/header-rdf-dcam.xml                2012-06-14/headers/header-rdf-dcam.xml  # ok - only date has changed (as expected)
#diff 2012-06-01/xmldata/dcam.xml                           2012-06-14/xmldata/dcam.xml             # ok - nothing changed (as expected)   
#diff 2012-06-01/xmldata/dcterms-properties.xml             2012-06-14/xmldata/dcterms-properties.xml # ok - only date has changed (as expected)
#diff 2012-06-01/xmldata/dcterms-ses.xml                    2012-06-14/xmldata/dcterms-ses.xml      # ok - nothing changed (as expected)   
#diff 2012-06-01/xmldata/dcterms-classes.xml                2012-06-14/xmldata/dcterms-classes.xml  # ok - only date has changed (as expected)
#diff 2012-06-01/xmldata/dcterms-ves.xml                    2012-06-14/xmldata/dcterms-ves.xml      # ok - only date has changed (as expected)
#diff 2012-06-01/headers/intro.dcmi-terms.xml               2012-06-14/headers/intro.dcmi-terms.xml # ok - nothing changed (as expected)   
#diff 2012-06-01/headers/header-doc-dcterms.xml             2012-06-14/headers/header-doc-dcterms.xml # ok - only date has changed (as expected)
#diff 2012-06-01/headers/header-rdf-dcterms.xml             2012-06-14/headers/header-rdf-dcterms.xml # ok - only date has changed (as expected)
#diff 2012-06-01/headers/header-rdf-dcelements.xml          2012-06-14/headers/header-rdf-dcelements.xml  # ok - only date has changed (as expected)
#diff 2012-06-01/xmldata/dcelements.xml                     2012-06-14/xmldata/dcelements.xml       # ok - only date has changed (as expected)
#diff 2012-06-01/headers/header-doc-history.xml             2012-06-14/headers/header-doc-history.xml # ok - only date has changed (as expected)
#diff 2012-06-01/headers/intro.history.xml                  2012-06-14/headers/intro.history.xml    # ok - nothing changed (as expected)   
#diff build-20120612/html/dcmi-terms/jump2location.js       build/html/dcmi-terms/jump2location.js  # ok - nothing changed (as expected)   
#diff build-20120612/.htaccess                              build/.htaccess                         # ok - nothing changed (as expected)   
#diff build-20120612/dctype.ttl                             build/dctype.ttl                        # ok - only the date has changed (as expected)
#diff build-20120612/dcam.ttl                               build/dcam.ttl                          # ok - only the date has changed (as expected)
#diff build-20120612/dcterms.ttl                            build/dcterms.ttl                       # ok - only the date has changed (as expected)
#diff build-20120612/dcelements.ttl                         build/dcelements.ttl                    # ok - only the date has changed (as expected)
#diff documents/2012/06/12/dces/index.shtml.rdf documents/2012/06/14/dces/index.shtml.rdf           # ok - only the date changed
#diff documents/2012/06/12/dces/index.shtml documents/2012/06/14/dces/index.shtml                   # ok - only the date changed
#diff documents/2012/06/12/dcmi-terms/index.shtml documents/2012/06/14/dcmi-terms/index.shtml       # ok - only the date changed
#diff documents/2012/06/12/dcmi-terms/jump2location.js documents/2012/06/14/dcmi-terms/jump2location.js    # ok - only the date changed
#diff /Users/tbaker/agit/website/build/html/dcmi-terms/index.shtml documents/2012/06/14/dcmi-terms/index.shtml # ok - files copied correctly
#diff /Users/tbaker/agit/website/build/html/dcmi-terms/jump2location.js documents/2012/06/14/dcmi-terms/jump2location.js # ok - files copied correctly
#diff /Users/tbaker/agit/website/build/html/history/index.shtml history/2012/06/14/index.shtml      # ok - file correctly staged
#diff 2012/06/14/dctype.rdf /Users/tbaker/agit/website/build/dctype.rdf                             # ok - files were copied over correctly
#diff 2012/06/14/dcam.rdf /Users/tbaker/agit/website/build/dcam.rdf                                 # ok - files were copied over correctly
#diff 2012/06/14/dcterms.rdf /Users/tbaker/agit/website/build/dcterms.rdf                           # ok - files were copied over correctly
#diff 2012/06/14/dcelements.rdf /Users/tbaker/agit/website/build/dcelements.rdf                     # ok - files were copied over correctly
#diff 2012/06/14/dctype.ttl /Users/tbaker/agit/website/build/dctype.ttl                             # ok - files were copied over correctly
#diff 2012/06/14/dcam.ttl /Users/tbaker/agit/website/build/dcam.ttl                                 # ok - files were copied over correctly
#diff 2012/06/14/dcterms.ttl /Users/tbaker/agit/website/build/dcterms.ttl                           # ok - files were copied over correctly
#diff 2012/06/14/dcelements.ttl /Users/tbaker/agit/website/build/dcelements.ttl                     # ok - files were copied over correctly
#diff 2012/06/14/.htaccess /Users/tbaker/agit/website/build/.htaccess                               # ok - files were copied over correctly
#diff ./12/dctype.rdf ./14/dctype.rdf         # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dcam.rdf ./14/dcam.rdf             # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dcterms.rdf ./14/dcterms.rdf       # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dcelements.rdf ./14/dcelements.rdf # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dctype.ttl ./14/dctype.ttl         # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dcam.ttl ./14/dcam.ttl             # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dcterms.ttl ./14/dcterms.ttl       # ok - what we used for testing differs from what is now staged only by date
#diff ./12/dcelements.ttl ./14/dcelements.ttl # ok - what we used for testing differs from what is now staged only by date
#diff ./12/.htaccess ./14/.htaccess           # ok - what we used for testing differs from what is now staged only by date

# 2012-06-12 tests - all passed :-)
#curl -L -I  --header "Accept: application/rdf+turtle" http://purl.org/dc/test/terms/instructionalMethod
#curl -L -I  --header "Accept: application/rdf+xml" http://purl.org/dc/test/elements/title
#curl -L -I  --header "Accept: application/rdf+xml" http://purl.org/dc/test/terms/instructionalMethod
#curl -L -I  --header "Accept: application/turtle" http://purl.org/dc/test/am/memberOf
#curl -L -I  --header "Accept: application/turtle" http://purl.org/dc/test/terms/instructionalMethod
#curl -L -I  --header "Accept: application/turtle" http://purl.org/dc/test/type/Image
