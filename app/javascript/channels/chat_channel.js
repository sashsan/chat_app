import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
    const groupElement = document.getElementById('group_id')
    if (!groupElement) { return }

    const groupId = groupElement.getAttribute('data-group-id')
    const chatSubscription = consumer.subscriptions.create({channel: "ChatChannel", group_id: groupId}, {
        connected() {
            console.log("Connected via ChatChannel " + groupId)
            const messagesContainer = document.getElementById('messages')
            if (messagesContainer) {
                messagesContainer.scrollTop = messagesContainer.scrollHeight
            }
        },

        disconnected() {
            console.log("Disconnected via ChatChannel " + groupId)
            const messageInput = document.getElementById('message_content')
            if (messageInput) {
                messageInput.value = ''
            }
            window.location.reload()
        },

        received(data) {
            console.log("Received via ChatChannel " + groupId)
            const messages = document.getElementById('messages')
            const messageInput = document.getElementById('message_content')
            const messageElement = document.createElement('div')
            messageElement.innerHTML = data
            messages.appendChild(messageElement)
            messageInput.value = ''
            messages.scrollTop = messages.scrollHeight
        }
    })
})
