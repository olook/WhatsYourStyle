# Whats Your Style?

_What's your style?_ is a quiz-based platform supported by a machine learning classification algorithm, that aims to find people's style through data acquired from a questionnaire.

# Background and Design

The goal of this project was to build a platform which could be capable of classifying new customers according to their fashion style. We assumed that a given person has an overall predominant style which is the one we are interested in discovering. 
There is a strong concept inside the business of Olook, which is providing rich shopping experience for customers. This is achieved by means of personalized showrooms and product recommendation. The knowledge of someone's style can provide the initial information we need to increase the chances to offer those products that best fits the taste of the customer.


## Questions

Classifying consists of grouping similar things together, having one attribute or a set of attributes in common. Therefore, to classify people by their fashion style, we needed a way to detect which are those attributes that are common to a given fashion style. To do that a fashion expert, prepared a set of 21 questions, where each of them had 4 possible answers. An answer was composed by the legend and image to better illustrate it.

## Survey

We conducted a survey with approx 500 people, with the help of a external agency(Livra). Livra had the task to interview people which belong to the target public which would represent the set of Olook customers. 
All respondents were asked to answer 21 questions. In the end they had to answer an additional question, where we explicit asked which style they think they belong to.

# Implementation

The system consists of a lightweight RESTful API supported by Weka's ML components. The idea behind using Weka's implementation instead of coding from scratch, is to use Weka's workbench to train and test the model. In this way the generated _.model_ file could be used interchangeblt between the workbench and the platform

## Training data

The data collected from the survey was used to train the machine learning algorithm. The training file is an _.arff_ format which is 
Weka's prefered format

## Model

Two different supervised algorithms had their classification performance tested. The C4.5 (known as J48 in Weka) and NaiveBayes. Currently, the C4.5 model is being used as it has outperformed NaiveBayes with a F-measure of 81%

# Installation & Setup

First install jruby. If you are using rvm

  rvm install jruby-1.7.4

If you like create your gemset

  rvm use jruby-1.7.4@whatsyourstyle --create

Go to config folder and change username and password in database.yml for you environment. If you can
find other ymls there to customize the system as you wish

Now execute

  bundle exec rake db:create:all

Then

  bundle exec rake db:migrate['development']

And finally

  bundle exec rake db:seed['development']

Finally create an access token for a given app 

  bundle exec rake authentication_token:create_access_token['development','olook']

Finally start goliath in versobse mode and watch the output

  jruby api.rb -sv

Access through browser or curl
  http://localhost:9000/v1/quizzes?api_token=[API_TOKEN]

  [{"name":"Whats your style?","description":"A quiz to discover Olook's customers
style"}]

Access the quiz and get the questions

  curl -H "Accept: application/json" -X GET http://localhost:9000/v1/quizzes/1?api_token=[API_TOKEN]

# Usage

Creating the database

    bundle exec rake db:create[ENV] or bundle exec rake db:create:all

Migrating

    bundle exec rake db:migrate[ENV]

To create the Quiz, just run the seed
  
    bundle exec rake db:seed[ENV] i.e bundle exec rake db:seed['development']

# Create an API Token

Only registered apps have access to the system. To get an API token, register your app with the following rake:

    bundle exec rake authentication:create_access_token["development","Olook"]

    >> Your access token is Tz_WfwdxtVSYI2PQrYMiYg

# Quiz API

## Retrivieng all available quizzes
  
    curl -H "Accept: application/json" -X GET http://localhost:9000/v1/quizzes?api_token=[API_TOKEN]

The server should reply with the following json

    {
       "name":"Whats your style?",
       "description":"A quiz to discover Olook's customers style",
       "questions":[
          {
             "id":10,
             "text":"Com qual desses sapatos você se identifica mais?",
             "answers":[
                {
                   "id":38,
                   "text":"Um peep toe bem sexy",
                   "image":"http://my.cdn/10C.jpg"
                },
                {
                   "id":40,
                   "text":"Um clássico e elegante peep toe",
                   "image":"http://my.cdn/10A.jpg"
                },
                {
                   "id":39,
                   "text":"Um slipper mais casual",
                   "image":"http://my.cdn/10D.jpg"
                },
                {
                   "id":37,
                   "text":"Uma bota bem descolada",
                   "image":"http://my.cdn/10B.jpg"
                }
             ]
          },
          {
             "id":20,
             "text":"Qual o look ideal para o trabalho?",
             "answers":[
                {
                   "id":79,
                   "text":"Sexy na medida certa",
                   "image":"http://my.cdn/20C.jpg"
                },
                {
                   "id":80,
                   "text":"Chic e mais básico",
                   "image":"http://my.cdn/20D.jpg"
                },
                {
                   "id":77,
                   "text":"Sofisticada e elegante",
                   "image":"http://my.cdn/20A.jpg"
                },
                {
                   "id":78,
                   "text":"Moderno e descolado",
                   "image":"http://my.cdn/20B.jpg"
                }
             ]
          }
       ]
    }

## Retrieving a specific quiz

To get access to a specific quiz, you have to pass the id number in your url or as a JSON attribute with a POST

    curl -H "Accept: application/json" -X GET http://localhost:9000/v1/quizzes/1?api_token=[API_TOKEN]

## Posting a challenge to the server

    curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"challenge":{"answers":{"21":"81","7":"27","3":"9","1":"1","13":"49","20":"78","8":"29","12":"47","18":"69","10":"37","11":"43"}}}' http://localhost:9000/v1/challenges/create?api_token=[API_TOKEN]

Where the answers object above is on the format "question\_id":"answer\_id"

## Running the server

Goliath is being used as the web server. Remember, goliath is both web server and a rack based server, there is no need for mongrel, thin, etc.
To run the server

    
You can also use a reverse proxy to run multiples instances of the platform


# Questions

Any questions regarding the theory, methods and design involved in this project, feel free to contact me at felipe@expertte.com

[<img src="http://www.expertte.com/assets/expertte_logo.png">](http://expertte.com/)

