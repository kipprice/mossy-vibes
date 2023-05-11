"use client"

import React, { useEffect, useState } from 'react';
import { Button, PageHeader } from '../shared';
import { FilterForm } from './FilterForm';
import { ExerciseLine } from './ExerciseLine';
import { ExerciseDetails } from '../../utils/types';
import { allowSleep, useNavigate } from '../../utils/client';

export type ExercisesProps = {
  exerciseDetails: ExerciseDetails[];  
};

export const Exercises: React.FC<ExercisesProps> = ({ exerciseDetails }) => {
    const [filterFn, setFilterFn] = useState<(v: ExerciseDetails) => boolean>(
        () => () => true
      )
      useEffect(() => {
        allowSleep()
      }, [])
      
      const navigate = useNavigate()

      const filteredExercises = exerciseDetails.filter(filterFn)
    return(
        <>
        <PageHeader title="All Exercises" />
        <div className="flex flex-col h-[calc(100%-48px)] p-8 gap-4 mt-12">
          <FilterForm setFilterFn={setFilterFn} />
          <div className="flex flex-col gap-4 overflow-y-auto flex-grow">
            {filteredExercises.map((ex) => (
              <ExerciseLine key={`exercise-${ex.id}`} exerciseDetails={ex} />
            ))}
            {filteredExercises.length === 0 ? (
              <div className="italic font-light text-center opacity-70 text-lg">
                (No exercises match your current filters)
              </div>
            ) : null}
          </div>
  
          <div className="col-span-4 w-full">
            <Button onClick={() => navigate('/exercises/*')}>
              Choose for Me
            </Button>
          </div>
        </div>
      </>
    );
};
