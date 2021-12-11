using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Lick
{
    public class WinCheckPoint : MonoBehaviour
    {
        PlayerMove my_move;
        private void Start()
        {
            my_move = GetComponentInParent<PlayerMove>();
        }
        public PlayerType m_type;
        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.name == "end_road")
            {
                if (m_type == PlayerType.Player)
                {
                    LickRunner.instance.Complete(my_move);
                }
                else
                {
                    LickRunner.instance.Faild(my_move);
                }
                Destroy(other.gameObject);
            }
        }
    }
    public enum PlayerType
    {
        Player,
        Ai
    }
}

