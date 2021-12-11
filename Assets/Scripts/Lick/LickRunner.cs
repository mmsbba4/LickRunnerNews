using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
namespace Lick
{
     public class LickRunner : MonoBehaviour
    {

        public List<PlayerMove> m_move;
        public static LickRunner instance;
        public List<SoliderShooting> solider;
        public GameObject[] EndRoadTrigger;
        private void Awake()
        {
            instance = this;
        }
        public UnityEvent StartGame;
        public UnityEvent CompleteGame;
        public UnityEvent FaildGame;
        public UnityEvent OnEndFlying;
        public void StartMoving()
        {
            StartGame.Invoke();
        }
        public WinProcess player_win;
        bool ended = false;
        public void EndFly()
        {
            if (ended) return;
            OnEndFlying.Invoke();
            ended = true;
        }
        public void Complete(PlayerMove move)
        {
            foreach (var i in EndRoadTrigger)
            {
                if(i!= null)
                {
                    Destroy(i);
                }
            }
            m_move.Remove(move);
            player_win.Player_Win();
            int x = 0;
            foreach (var i in solider)
            {
                i.StartShooting(m_move.ToArray()[x].transform);
                if (x == 0) x = 1; else x = 0;
            }
            foreach (var i in m_move.ToArray())
            {
                i.PlayerDeath();
            }
            CompleteGame.Invoke();
        }

        public void Faild(PlayerMove move)
        {
            m_move.Remove(move);
            foreach (var i in m_move.ToArray())
            {
                i.PlayerDeath();
            }
            int x = 0;
            foreach (var i in solider)
            {
                i.StartShooting(m_move.ToArray()[x].transform);
                if (x == 0) x = 1; else x = 0;
            }
            FaildGame.Invoke();
        }
    }
}

