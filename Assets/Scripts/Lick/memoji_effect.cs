using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick
{
    public class memoji_effect : MonoBehaviour
    {
        public GameObject happy, disgusted, fire;
        public PlayerMove m_move;
        public Tongue m_tongue;
        void Update()
        {
            if (m_tongue.is_active_eat_effect)
            {
                switch (m_move.current_emoji)
                {
                    case emoji.happy:
                        {
                            fire.SetActive(false);
                            happy.SetActive(true);
                            disgusted.SetActive(false);
                            break;
                        }
                    case emoji.disgust:
                        {
                            fire.SetActive(false);
                            happy.SetActive(false);
                            disgusted.SetActive(true);
                            break;
                        }
                    case emoji.fire:
                        {
                            fire.SetActive(true);
                            happy.SetActive(false);
                            disgusted.SetActive(false);
                            break;
                        }
                }
            }
            else
            {
                happy.SetActive(false);
                disgusted.SetActive(false);
                fire.SetActive(false);
            }

        }
    }
}

