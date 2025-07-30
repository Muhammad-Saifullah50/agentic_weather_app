from agents import Runner
import chainlit as cl

from ai_agents.weather_agent import weather_agent


@cl.on_message
async def main(message: cl.Message):
    
    result = await Runner.run(
        weather_agent,
        input=message.content,
    )
    
    await cl.Message(result.final_output).send()

if __name__ == "__main__":
    cl.run(main())
