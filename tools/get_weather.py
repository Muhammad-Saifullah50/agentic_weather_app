from agents import function_tool


@function_tool
def get_weather(city: str) -> str:
    """
    Get the current weather for a given city.
    """
    print(f"Fetching weather for {city}...")
    return f"The current weather in {city} is sunny with a temperature of 30°C."
