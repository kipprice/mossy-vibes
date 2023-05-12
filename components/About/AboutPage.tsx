import React from 'react';
import { LogFooter, PageHeader } from '../shared';

export type AboutPageProps = {
    
};

export const AboutPage: React.FC<AboutPageProps> = ({  }) => {
    return(
        <>
        <PageHeader title={'About'} />
        <div className='flex flex-col gap-8 text-xl font-light p-4 pt-20'>
        <p>Welcome to Mossy Vibes!</p>
        <p>We created Mossy Vibes as a way to make it easier to find meditative and mindful moments, no matter where you are mentally or physically. The exercises are short, and designed to be read rather than listened to; and every day, we try to add a new one!</p>
        <p>We don&apos;t track any of your data, but we do store your preferences directly on your device. This information is only visible to you.</p>
        <p>If you enjoy using Mossy Vibes and want to support us as we create new content and features, please consider <a href='https://www.buymeacoffee.com/mossyvibes' className='underline font-base bg-off-white bg-opacity-10 rounded-md p-0.5'>donating or becoming a member!</a></p>
        
        </div>

        <LogFooter />
        </>
    );
};
