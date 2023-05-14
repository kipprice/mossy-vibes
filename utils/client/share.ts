export const generateShareLinks = () => {
    const url = 'https://mossyvibes.com'
    const title = 'Meditation for busy people'
    const body = encodeURI("I've been using Mossy Vibes to fit meditation into my day, and I think you might like it too!")
    return {
        facebook: `https://www.facebook.com/sharer/sharer.php?u=${url}`,
        twitter: `https://twitter.com/intent/tweet?url=${url}&text=${body}`,
        linkedIn: `https://www.linkedin.com/sharing/share-offsite/?url=${url}/&summary=${body}`,
        email: `mailto:?subject=${title}&body=${body} ${url}`
    }
}