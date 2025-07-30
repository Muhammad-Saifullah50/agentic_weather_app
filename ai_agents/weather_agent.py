from agents import Agent
from tools.get_weather import get_weather
from models.gemini import gemini_model

weather_agent = Agent(
        name='weather-agent',
        instructions='You are a helpful agent that provides weather information based on user queries in a 4 line poem form. You can use the "get_weather" tool to fetch weather data.',
        tools=[get_weather],
        model=gemini_model
    )