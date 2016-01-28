(function () {

    var http = require('http');
    var express = require('express');
    var app = express();
    var mongodb = require('./mongodb');
    var PORT = process.env.PORT || 8080;
    var apiKey = 'MDowNjU1ZTgzZS1hMmI3LTExZTUtYjQyNC0zZmZiOGRjNmE3OWI6bGY3aWJkME1zMXBueWd0NjBEQXVnV2VYaWJxV0F2NXNoTVdh';
    var baseLink = 'https://lcboapi.com';
    var allDrinks = [];
    var drink;
    var waterfall = require('async-waterfall');
    var request = require('request');
    var pages = [];
    /*
    **********************************************************
    *****************  API ENDPOINTS *************************
    **********************************************************
    */

    function performGetRequest(link) {
        var request = require('request');
            request(link, function (error, response, body) {
                if (!error && response.statusCode == 200) {
                    return body;
                }
            });
    }    

    refreshDatabase = function () {
        console.log('Please Wait...')
        waterfall ([
            //Completes request for the first page
            function (callback) {
                var link = baseLink + '/products?access_key=' + apiKey + '&per_page=100'
                var body;
                request(link, function (error, response, responseBody) {
                    if (!error && response.statusCode == 200) {
                        body = responseBody;
                        callback(null, body);
                    }
                });
            }, function (body, callback) {
                
                //Convert body to JSON
                if (body !== "") {
                    body = JSON.parse(body);
                }
                pages[0] = body;
                var numberOfPages = body.pager.total_pages;
                if (numberOfPages > 1) {
                    callback(null, body, numberOfPages);
                }

                //Completes the request for all subsequent pages
            }, function (body, numberOfPages, callback) {
                function getRemainingPages (pager, index) {
                    link = baseLink + pager.next_page_path;//baseLink + '/products?access_key=' + apiKey + '&per_page=100&page=' + i;
                    if (pager.next_page_path) {
                        request(link, function (error, response, responseBody) {
                            if (!error && response.statusCode == 200) {
                                if (responseBody) {
                                    responseBody = JSON.parse(responseBody);
                                }
                                pages[index] = responseBody;
                                console.log(index + '/' + (numberOfPages-1));
                                getRemainingPages(responseBody.pager, index+1);
                            }
                        });

                    } else {
                        callback(null);
                        return;
                    } 
                }
                getRemainingPages(body.pager, 1);
            }, function (callback) {
                console.log('Refresh Complete');
                console.log('Pages Updatated: ' + (pages.length - 1));

                //Save updated data to the database.
                mongodb.saveDrinks(pages);
            }

        ])   
    }

    refreshDatabase();

    app.get('/drink-for-price', function (req, res) {
        var price = req.query.price;
        mongodb.getDrinksForPrice(req, res, price);
    });

    app.get('/max-fucked-up-for-price', function (req, res) {
        var price 
    });    
    app.listen(PORT);
    console.log('The magic happens on port ' + PORT);

}());