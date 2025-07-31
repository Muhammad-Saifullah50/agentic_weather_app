import os
from agents import function_tool
from dotenv import load_dotenv
import requests

@function_tool
def get_weather(city: str) -> str:
    """
    Get the current weather for a given city from api.
    """
    load_dotenv()
    
    api_key:str | None = os.getenv("WEATHER_API_KEY")
    url = "https://open-weather13.p.rapidapi.com/city"
    
    if not api_key:
        return "API key not found. Please set the WEATHER_API_KEY environment variable."
    
    querystring = {"city":"new york","lang":"EN"}

    headers = {
        "X-RapidAPI-Key": api_key,
        "X-RapidAPI-Host": "open-weather13.p.rapidapi.com"
    }
    
    response = requests.get(url, headers=headers, params=querystring)
    
    data = response.json()
    
    if "error" in data:
        return f"Error fetching weather data: {data['error']['message']}"
    
    
    current_weather = data["weather"][0]
    main = data["main"]
    
    celcius_temp = (main["temp"] - 32) * 5.0/9.0
    celcius_min_temp = (main["temp_min"] - 32) * 5.0/9.0
    celcius_max_temp = (main["temp_max"] - 32) * 5.0/9.0
    celcius_feels_like = (main["feels_like"] - 32) * 5.0/9.0    

    return f"The current weather in {city} is {current_weather['description']} with a temperature of {celcius_temp}°C. The feels like temperature is {celcius_feels_like}°C and the humidity is {main['humidity']}%. Minimum temperature is {celcius_min_temp}°C and maximum temperature is {celcius_max_temp}°C."
