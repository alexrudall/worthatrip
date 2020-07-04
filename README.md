# worththetrip

## What is this?
A microservice to get the distance between 2 UK postcodes. Built for my friends at [Jerk Off BBQ](https://www.jerkoffbbq.com/).

Feel free to use it for any non-evil purpose!

## How does it work?
Uses plain Ruby rather than a framework to keep the size down and allow deployment on [Vercel](https://vercel.com/)'s generous free tier.

CSS by [Tailwind](https://tailwindcss.com/).

## Where does the data come from?

Utilises the [Open Postcode Geo API](https://www.getthedata.com/open-postcode-geo-api) to get the eastings and northings of each postcode. Pythagoras' theorem is used to calculate the distance between each point.

## How do I use the API?
Pass the `from` and `to` postcodes as query strings to get the 'as the crow flies' distance between the postcodes in metres.

The Open Postcode Geo API encourages the use of (URL-encoded `%20`) spaces since some postcodes can only be distinguished from either with spaces. Letter case doesn't matter.

### Example

`https://worththetrip.vercel.app/api/v1/handler?from=EC3N%204AB&to=M1%201AG`

## Any limitations?
Excludes Northern Ireland due to licensing requirements.

## Data Attribution
Office for National Statistics licensed under the Open Government Licence v3.0
