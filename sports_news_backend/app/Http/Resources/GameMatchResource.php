<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GameMatchResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'home_team' => new TeamResource($this->homeTeam),
            'away_team' => new TeamResource($this->awayTeam),
            'league' => new LeagueResource($this->league),
            'sport' => new SportResource($this->sport),
            'match_time' => $this->match_time->toIso8601String(),
            'status' => $this->status,
            'home_score' => $this->home_score,
            'away_score' => $this->away_score,
            'live_minute' => $this->live_minute,
        ];
    }
}
