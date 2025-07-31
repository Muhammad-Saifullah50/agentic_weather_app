from agents import Runner
import chainlit as cl

from ai_agents.weather_agent import weather_agent


@cl.on_chat_start
async def on_start():
    cl.user_session.set("history", [])


@cl.on_message
async def main(message: cl.Message):
    history: list[dict[str, str]] = cl.user_session.get("history", [])

    try:
        history.append(
        {
            "role": "user",
            "content": message.content,
        }
    )
    
        result = await Runner.run(
            weather_agent,
            input=history,
        )
    
        await cl.Message(result.final_output).send()
    
        history.append(
        {
            "role": "assistant",
            "content": result.final_output,
        }
    )
    except Exception as e:
        await cl.Message(f"Error: {str(e)}").send()

if __name__ == "__main__":
    cl.run(main())
